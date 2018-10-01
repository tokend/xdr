%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-ledger-entries-account-role-permission.h"

namespace stellar
{
/* ManageAccountRolePermissionOp

 Creates, updates or deletes account role permission

 Threshold: med

 Result: ManageAccountRolePermissionResult
*/

enum ManageAccountRolePermissionOpAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

struct CreateAccountRolePermissionData
{
    uint64 roleID;
    OperationType opType;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct UpdateAccountRolePermissionData
{
    uint64 permissionID;
    uint64 roleID;
    OperationType opType;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct RemoveAccountRolePermissionData
{
    uint64 permissionID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct ManageAccountRolePermissionOp
{
    union switch (ManageAccountRolePermissionOpAction action)
    {
    case CREATE:
        CreateAccountRolePermissionData createData;
    case UPDATE:
        UpdateAccountRolePermissionData updateData;
    case REMOVE:
        RemoveAccountRolePermissionData removeData;
    } data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAccountRolePermissionOp Result ********/

enum ManageAccountRolePermissionResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    NOT_FOUND = -1,
    PERMISSION_ALREADY_EXISTS = -2
};

union ManageAccountRolePermissionResult switch (ManageAccountRolePermissionResultCode code)
{
    case SUCCESS:
        struct {
            uint64 permissionID;

            // reserved for future use
            union switch (LedgerVersion v)
            {
            case EMPTY_VERSION:
                void;
            }
            ext;
        } success;
    default:
        void;
};

}
