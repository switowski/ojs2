## -*- coding: utf-8 -*-


"""
Command line interface for various OJS tasks:

Usage: python ojs_tasks [command]

Commands:
  --author-reminder    Sends reminders to authors that they have some
                       copyright edits pending.

Examples:
    python ojs_tasks --author-reminder
"""
import datetime
import MySQLdb
import smtplib
import sys
from time import sleep

#TODO: disable DEVELOPMENT_MODE, change SYSTEM_ADMIN_EMAIL to a normal email

# Some config variables
DEVELOPMENT_MODE = True  # If True, then it only prints the email's content
BASE_URL = "dummy_base_url"  # Base user for the website
SYSTEM_ADMIN_EMAIL = "dummy_admin"  # This will be used in "From" field of the e-mail

DB_USER = "dummy_db_username"
DB_PASSWORD = "dummy_db_password"
DB_NAME = "dummy_db_name"
DB_HOST = "dummy_db_host"
DB_PORT = "dummy_db_port"


def print_usage():
    """Print help."""
    print __doc__


def db_connect():
    """ This functions tries to connect to the MySQL db and returns the connector or false
    """
    try:
        connection = MySQLdb.connect(host=DB_HOST,
                                     port=int(DB_PORT),
                                     user=DB_USER,
                                     passwd=DB_PASSWORD,
                                     db=DB_NAME)

        return connection
    except MySQLdb.Error, e:
        print "Error %d: %s" % (e.args[0], e.args[1])
        return False


def send_mail(fromadd,
              toaddr,
              cc=[],
              subject="",
              content=""):
    """Function that is used to send emails
    @param fromaddr: [string] sender
    @param toaddr: [string] list of receivers (separated by ',')
    @param subject: [string] subject of the email
    @param content: [string] content of the email
    """
    # TODO Improve the send_mail function ?
    server = smtplib.SMTP('localhost')
    message = """From: {fromadd}
To: {to}
Subject: {subject}

{content}
""".format(fromadd=fromadd, to=toaddr, subject=subject, content=content)

    server.sendmail(fromadd, [toaddr], message)
    server.quit()


def author_reminder():
    """Checks if it is time to remind author about copyediting and sends an email"""

    # TODO Interval here doesn't matter - the interval is setup by the CRON job, if we run the job once per week, then the email is send once per week
    # you should change it in case the cronjob is run everyday and you want the emails to be send less often
    AR_NOTIFICATION_INTERVAL = datetime.timedelta(days=1)
    AR_EMAIL_TITLE = "Copyediting Review Reminder"
    AR_EMAIL_TEXT = """
{author_name}:

This is a gentle reminder that we are still waiting for you to complete the copy-editing step for "{article_title}". You can do it by following these steps:

1. Click on the Submission URL below.
2. Log into the Series and click on the File that appears in Step 1.
3. Open the downloaded submission.
4. Review the text, including copyediting proposals and Author Queries.
5. Make any copyediting changes that would further improve the text.
6. When completed, upload the file in Step 2.
7. Click on METADATA to check indexing information for completeness and accuracy.
8. Send the COMPLETE email to the editor and copyeditor.

Submission URL: {BASE_URL}/{JOURNAL}/author/submissionEditing/{article_id}
Username: {username}

This is the last opportunity to make substantial copyediting changes to the submission. The proofreading stage, that follows the preparation of the galleys, is restricted to correcting typographical and layout errors.

In order to conclude the publication process in due time, it is very important that you complete this task as soon as possible. If you are unable to undertake this work at this time or have any questions, please contact me. Thank you for your contribution to this Series.

System Administrator
Valeria Brancolini
    """

    connection = db_connect()
    if connection:
        cursor = connection.cursor()
        # If the submissions was last time send before today() - AR_NOTIFICATION_INTERVAL
        # then it's time to remind the author again
        should_remind = datetime.datetime.now() - AR_NOTIFICATION_INTERVAL
        reminded_before = should_remind.strftime("%Y-%m-%d %H:%M:%S")
        # Queue to select:
            # assoc_id - article's id to get the article's title
            # user_id - to get user's email
            # signoff id - to change the date_notified for it
        cursor.execute('SELECT signoff_id, assoc_id, user_id FROM signoffs WHERE date_notified < "%s" AND symbolic="SIGNOFF_COPYEDITING_AUTHOR" and date_completed IS NULL' %
                       reminded_before)
        for (signoff_id, article_id, user_id) in cursor.fetchall():
            # For each article get article title, user email and send the reminder
            cursor.execute('SELECT email, first_name, middle_name, last_name, username FROM users WHERE user_id = %s' % user_id)
            (user_email, first_name, middle_name, last_name, username) = cursor.fetchone()
            # Create user name that will be used in the email
            author_name = " ".join(filter(None, [first_name, middle_name, last_name]))

            cursor.execute('SELECT setting_value FROM article_settings WHERE article_id = %s and setting_name = "title"' % article_id)
            (article_title,) = cursor.fetchone()

            # Get the journal's name
            cursor.execute('SELECT journal_settings.journal_id, setting_value FROM journal_settings \
                            INNER JOIN articles ON articles.journal_id = journal_settings.journal_id \
                            WHERE setting_name = "title" AND articles.article_id = %s' % article_id)

            (journal_id, journal_title,) = cursor.fetchone()

            # Get journal path
            cursor.execute("SELECT path FROM journals WHERE journal_id=%s", (journal_id))
            (journal_path,) = cursor.fetchone()

            # send email to user with a reminder
            message = AR_EMAIL_TEXT.format(article_title=article_title, BASE_URL=BASE_URL, JOURNAL=journal_path,
                                           article_id=article_id, author_name=author_name, username=username)
            if DEVELOPMENT_MODE:
                print """Following e-mail would be send:
                    From: %s
                    To : %s
                    Subject: %s
                    Content: %s""" % (SYSTEM_ADMIN_EMAIL, user_email, AR_EMAIL_TITLE, message)
            else:
                send_mail(fromadd=SYSTEM_ADMIN_EMAIL, toaddr=user_email,
                          subject=AR_EMAIL_TITLE, content=message)

            # update the date_notified with today's date so next reminder is send after a week
            now = datetime.datetime.now().replace(microsecond=0)
            cursor.execute('UPDATE signoffs SET date_notified=%s WHERE signoff_id = %s', (now, signoff_id))
            sleep(1)  # Sleep 1 second to not clog the sendmail
        connection.close()
    else:
        print "ERROR: No DB connection!"


def main():
    """Main function"""
    if '--help' in sys.argv or \
       '-h' in sys.argv:
        print_usage()
    else:
        try:
            cmd = sys.argv[1]
        except IndexError:
            print_usage()
            sys.exit(1)
        if cmd == '--author-reminder':
            author_reminder()
        else:
            print "ERROR: Please specify a command.  Please see '--help'."
            sys.exit(1)


if __name__ == '__main__':
    main()
