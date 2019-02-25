%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-operation-manage-signer.h"

namespace stellar
{

/* CreateAccount
Creates and funds a new account with the specified starting balance.

Threshold: med

Result: CreateAccountResult

*/

//: CreateAccountOp is used to create new account
struct CreateAccountOp
{
    //: ID of account to be created
    AccountID destination;
    //: ID of account which contributed account creation
    AccountID* referrer;
    //: ID of role to be attached to account
    uint64 roleID;

    //: Array of data about signers to be created for `destination` account
    UpdateSignerData signersData<>;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateAccount Result ********/

//: Result codes of CreateAccountOp
enum CreateAccountResultCode
{
    //: Means that `destination` account was successfully created with signers specified in `signersData`
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Source cannot be destination
    INVALID_DESTINATION = -1,
    //: There is already exist account with such account ID
    ALREADY_EXISTS = -2, // account already exist
    //: Sum of weight with different identity must be more or equal threshold
    INVALID_WEIGHT = -3,
    //: There is no role with such id
    NO_SUCH_ROLE = -4,
    //: Failed to create signer for account cause of invalid `signersData`.
    //: See `createSignerErrorCode`
    INVALID_SIGNER_DATA = -5,
    //: Not allowed to create account without signers
    NO_SIGNER_DATA = -6 // empty signer data array not allowed
};

//: CreateAccountSuccess is used to pass useful params if operation is success
struct CreateAccountSuccess
{
    //: Unique integer identifier of new account
    uint64 sequentialID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of operation applying
union CreateAccountResult switch (CreateAccountResultCode code)
{
case SUCCESS:
    CreateAccountSuccess success;
case INVALID_SIGNER_DATA:
    //: Is used to determine the reason of signer creation failure
    ManageSignerResultCode createSignerErrorCode;
default:
    void;
};

}
