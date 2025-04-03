# 1) create user:

curl '<CTRL_PLANE_URL>/api/v1/users' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'authorization: Bearer <TOKEN>' \
  --data-raw '{ "email": "tester01@testing.zzz" }'

# response:
# {
#     "id": "a0160ed4-37ef-4337-a7bb-9797c67a1e03",
#     "username": "tester01@testing.zzz",
#     "tempPassword": "123$#@456"
# }

# 2) create a project in the "default" department:
curl 'h<CTRL_PLANE_URL>/api/v1/org-unit/projects' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'authorization: Bearer <TOKEN>' \
  --data-raw '{
  "clusterId": "d80e86e0-a637-4e9d-8864-6c44ab23fbe5",
  "parentId": "4529673",
  "resources": [
    {
      "nodePool": { "name": "default", "id": "101068" },
      "gpu": { "deserved": 0, "limit": -1, "overQuotaWeight": 2 },
      "cpu": { "deserved": null, "limit": -1, "overQuotaWeight": 2 },
      "memory": {
        "deserved": null,
        "limit": -1,
        "overQuotaWeight": 2,
        "units": "Mib"
      }
    }
  ],
  "name": "test-v2",
  "description": "",
  "schedulingRules": {
    "trainingJobTimeLimitSeconds": null,
    "interactiveJobTimeLimitSeconds": null
  },
  "defaultNodePools": null
}
'

# response:
# {
#     "description": "",
#     "nodeTypes": {},
#     "resources": [
#         {
#             "nodePool": {
#                 "id": "101068",
#                 "name": "default"
#             },
#             "gpu": {
#                 "deserved": 8,
#                 "limit": -1,
#                 "overQuotaWeight": 2
#             },
#             "cpu": {
#                 "limit": -1,
#                 "overQuotaWeight": 2
#             },
#             "memory": {
#                 "limit": -1,
#                 "overQuotaWeight": 2,
#                 "units": "Mib"
#             },
#             "priority": "Normal"
#         }
#     ],
#     "name": "test-v2",
#     "clusterId": "d80e86e0-a637-4e9d-8864-6c44ab23fbe5",
#     "id": "4530100",
#     "parentId": "4529673",
#     "requestedNamespace": "",
#     "enforceRunaiScheduler": true,
#     "status": {
#         "phase": "Creating",
#         "nodePoolQuotaStatuses": [
#             {
#                 "allocated": {},
#                 "allocatedNonPreemptible": {},
#                 "requested": {},
#                 "nodePoolName": "default",
#                 "nodePoolId": "101068"
#             }
#         ],
#         "quotaStatus": {
#             "allocated": {},
#             "allocatedNonPreemptible": {},
#             "requested": {}
#         },
#         "additionalStatusData": {
#             "conditions": null
#         }
#     },
#     "totalResources": {},
#     "createdAt": "2025-04-03T22:56:32.931054587Z",
#     "updatedAt": "2025-04-03T22:56:32.931054587Z",
#     "createdBy": "admin@testing.zzz",
#     "parent": {
#         "id": "4529673",
#         "name": "default"
#     },
#     "effective": {
#         "defaultNodePools": [
#             "default"
#         ],
#         "nodeTypes": {}
#     },
#     "overtimeData": {}
# }

# 3) create access rule: assign L2 researcher role to the user, scoped to a specific project
curl '<CTRL_PLANE_URL>/api/v1/authorization/access-rules' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'authorization: Bearer <TOKEN>' \
  --data-raw '{
  "scopeId": "4530100",
  "scopeType": "project",
  "subjectId": "tester01@testing.zzz",
  "subjectType": "user",
  "roleId": 8
}'

# response:
# {
#     "subjectId": "tester01@testing.zzz",
#     "subjectType": "user",
#     "roleId": 8,
#     "scopeId": "4530100",
#     "scopeType": "project",
#     "clusterId": "d80e86e0-a637-4e9d-8864-6c44ab23fbe5",
#     "roleName": "L2 researcher",
#     "scopeName": "test",
#     "id": 37340601,
#     "createdAt": "2025-04-03T22:52:43.743939408Z",
#     "updatedAt": "2025-04-03T22:52:43.743255014Z",
#     "tenantId": 212,
#     "createdBy": "admin@testing.zzz"
# }