curl -X POST \
 https://fcm.googleapis.com/v1/projects/test-secure-gates/messages:send \
 -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGVhcGlzLmNvbS9nb29nbGUuaWRlbnRpdHkuaWRlbnRpdHl0b29sa2l0LnYxLklkZW50aXR5VG9vbGtpdCIsImlhdCI6MTcxNTE3MTgxNSwiZXhwIjoxNzE1MTc1NDE1LCJpc3MiOiJmaXJlYmFzZS1hZG1pbnNkay1pN2wzckB0ZXN0LS1nYXRlcy5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsInN1YiI6ImZpcmViYXNlLWFkbWluc2RrLWk3bDNyQHRlc3QtLWdhdGVzLmlhbS5nc2VydmljZWFjY291bnQuY29tIiwidWlkIjoidXNlci11aWQifQ.E-lmZ65mC6jwrBKw997sDOn761pvoAonx2NeYbJ0B1QFLTS7S0qFXCBiGhElKtma0DucMF3cWV2EhaWRL9OWT-evwVmsBJSCWWhyW8ZTtW8BQLPRglmv2vktjX-Avc6BdpIyX6n78XTvGMewzmkrUZyiRki1ehsLq4dcCVy8gNbYzEius5prhI_kuEjlrJYWiUJDT8VufXF5PBjUjzL0zFF8w_teMx-ry8oVy-Ffo9Jr6sIaDGZ5Xv-mYU3P86n0rEniDmkGQZT8KSC1UOywZTfgw9PQyewtFWtFjfhU605A7go9MwyCIA6xHjIlR_DfEyLwRiX8PTBfBXtoTl8i4Q'
-H 'Content-Type: application/json' \
-d '{
"message":{
"token":"esCmmcJURmiftSrmJpYYzS:APA91bF1kfqk_O6HzPM9dmbyDTMMfF9pfvzui-YvsXS457mbF_tYGnZRL4TifGwCWJW3WSal8vavnS4D5eHI2EHMPWJdjciJuxsgiiK3BSuOhLvPgAfmJXfYKEX-vaSAKpHFT79wY8Hk",
"notification":{
"body":"This is an FCM notification message!",
"title":"FCM Message"
}
}
}'

 <!-- -H 'Postman-Token: c8af5355-dbf2-4762-9b37-a6b89484cf07' \ -->
 <!-- -H 'cache-control: no-cache' \ -->
