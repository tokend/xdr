%#include "xdr/Stellar-types.h"

namespace stellar
{

struct AccountRolePermissionEntry
{
    uint64 permissionID;
    uint64 accountRoleID;
    OperationType opType;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}