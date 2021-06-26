| Feature             | Admin Activity Logs                                                    | Data Access Logs                              | System Event Logs                                        | Policy Denied Logs                                     |
|---------------------|------------------------------------------------------------------------|-----------------------------------------------|----------------------------------------------------------|--------------------------------------------------------|
| **Logs for**        | API calls or other actions that modify the configuration  of resources | Reading configuration of resources            | Google Cloud Administrative Actions                      | Denial of attempted access via user or service account |
| **Default Enabled** | Yes                                                                    | No                                            | Yes                                                      | Yes                                                    |
| **VM Examples**     | VM creation, patching , resources, Change in IAM permissions           | Listing resources                             | Host maintenance, Instance preemption, Automatic restart | Security policy violation logs                         |
| **Cloud Storage**   | Modify bucket or object                                                | Read/Write/Update bucket or object            |                                                          |                                                        |
| **Access Needed**   | Logging/Logs Viewer or Project/Viewer                                  | Logging/Private Logs Viewer ,or Project Owner | Logging/Logs Viewer or Project/Viewer                    | Logging/Logs Viewer or Project/Viewer                  |




## Cloud logging  - controlling and routing


1. Logs from various sources reache log router
2. log router checks against configured rules
3. Two types of logs buckets
   3.1. _Requeired: Admin activity, System Events and Access Transparency Logs
    3.2. _Default
4. Can export logs to any of the various GCP databases..
5. Cloud logging agents can be installed in VMs(does this go for containers also ?)