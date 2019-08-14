%#include "xdr/types.h"
%#include "xdr/ledger-entries-identifier.h"

namespace stellar
{

//: CreateAccountOp is used to create new account
struct CreateAccountOp
{
    //: ID of account to be created
    AccountID destination;
    //: ID of an another account that introduced this account into the system.
    //: If account with such ID does not exist or it's Admin Account. Referrer won't be set.
    AccountID referrer;

    PublicKey key;

    longstring* mainData;
    longstring* additionalData;

    longstring externalIdentifiers<>;

    AccountID recoveryProviders<>;
    uint32 recoveryPower;

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
    NO_RECOVERY_PROVIDERS = -3,
    INVALID_RECOVERY_POWER = -4
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
default:
    void;
};

}
