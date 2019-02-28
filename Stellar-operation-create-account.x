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
    //: ID of an another account that introduced this account into the system
    AccountID* referrer;
    //: ID of role which would be attached to account
    uint64 roleID;

    //: Array of data about created signers for `destination` account
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
    //: Source account cannot be the same as the destination account
    INVALID_DESTINATION = -1,
    //: Account with such ID already exists
    ALREADY_EXISTS = -2, // account already exist
    //: Sum of weights of signers with different identities must exceed the threshold (for now 1000)
    INVALID_WEIGHT = -3,
    //: There is no role with such id
    NO_SUCH_ROLE = -4,
    //: Failed to create signer for account because `signersData` is invalid.
    //: See `createSignerErrorCode`
    INVALID_SIGNER_DATA = -5,
    //: Not allowed to create account without signers
    NO_SIGNER_DATA = -6 // empty signer data array not allowed
};

//: Result of successful application of `CreateAccount` operation
struct CreateAccountSuccess
{
    //: Unique unsigned integer identifier of the new account
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
    //: `createSignerErrorCode` is used to determine the reason of signer creation failure
    ManageSignerResultCode createSignerErrorCode;
default:
    void;
};

}
