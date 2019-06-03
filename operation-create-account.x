%#include "xdr/types.h"
%#include "xdr/operation-manage-signer.h"

namespace stellar
{

//: CreateAccountOp is used to create new account
struct CreateAccountOp
{
    //: ID of account to be created
    AccountID destination;
    //: ID of an another account that introduced this account into the system.
    //: If account with such ID does not exist or it's Admin Account. Referrer won't be set.
    AccountID* referrer;
    //: ID of the role that will be attached to an account
    uint64 roleID;

    //: Array of data about 'destination' account signers to be created
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
    //: Means that `destination` account has been successfully created with signers specified in `signersData`
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Source account cannot be the same as the destination account
    INVALID_DESTINATION = -1,
    //: Account with such an ID already exists
    ALREADY_EXISTS = -2, // account already exist
    //: Sum of weights of signers with different identities must exceed the threshold (for now, 1000)
    INVALID_WEIGHT = -3,
    //: There is no role with such an ID
    NO_SUCH_ROLE = -4,
    //: Creation of a signer for an account is failed because `signersData` is invalid.
    //: See `createSignerErrorCode`
    INVALID_SIGNER_DATA = -5,
    //: It is not allowed to create accounts without signers
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

//: Result of operation application
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
