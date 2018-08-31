from pprint import pprint
import json

PRZ = '40:30:30:31:50:52:5a:3f:3b:46:46'
ACK =  '40:30:30:31:41:43:4b ...............'
ACK1 = '40:30:30:31:41:43:4b'
ACK2 = '40:30:30:31:41:43'
ACK3 = '40:30:30:31:41'

with open('mks.json', 'r') as f:
    data = json.load(f)
    # print(data)

if not data:
    print('Not loaded...') 
# print(data[0]['_source']['layers'].get(['tcp']))

for pkg in data: 
    try:
        payload = pkg['_source']['layers']['tcp']['tcp.payload']
        
        if payload == PRZ:
            print('{}\t{}\t{}'.format('PRZ', payload, pkg['_source']['layers']['frame']['frame.time']))
        if ACK1 in payload or ACK2 in payload or ACK3 in payload:
            print('{}\t{}\t{}'.format('ACK', ACK, pkg['_source']['layers']['frame']['frame.time']))
    except:
        pass
     
# for pkg in data:
#     print(data['_index'])
#     try:
#         print(data['_source']['layers']['frame']['tcp']['tcp.payload'])
#     except:
#         pass