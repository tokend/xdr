%#include "xdr/types.h"

namespace stellar 
{

struct ChangeRoleOp 
{
    AccountID accountID;
    uint64 roleID;

    longstring details;

    EmptyExt ext;
};

enum ChangeRoleResultCode 
{
    SUCCESS = 0,

    INVALID_DETAILS = -1,
    ACCOUNT_NOT_FOUND = -2,
    ROLE_NOT_FOUND = -3
};

union ChangeRoleResult switch (ChangeRoleResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};
}