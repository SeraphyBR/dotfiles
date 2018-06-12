import os
from apiclient import discovery
from oauth2client import file

DIR = os.path.dirname(os.path.realpath(__file__))
CREDENTIALS_PATH = os.path.join(DIR, 'credentials.json')

gmail = discovery.build('gmail', 'v1', credentials=file.Storage(CREDENTIALS_PATH).get())
messages = gmail.users().messages().list(userId='me', labelIds=['INBOX', 'UNREAD'],
        maxResults=50000).execute()
message_ids = list(map(lambda msg : msg['id'], messages['messages']))

chunk_size = 1000 # max limit per request is 1k


for i in range(0, len(message_ids), chunk_size):
    chunk = message_ids[i:i+chunk_size]
    gmail.users().messages().batchModify(userId='me', body={ 'ids': chunk, 'removeLabelIds': ['UNREAD'] }).execute()
