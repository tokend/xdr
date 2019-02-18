%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-operation-manage-signer.h"

namespace stellar
{

/* CreateAccount
Creates and funds a new account with the specified starting balance.

Threshold: med

Result: CreateAccountResult

*/

struct CreateAccountOp
{
    AccountID destination; // account to create
    AccountID* referrer;
	uint64 roleID;

	UpdateSignerData signersData<>;

	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateAccount Result ********/

enum CreateAccountResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0, // account was created

    // codes considered as "failure" for the operation
    INVALID_DESTINATION = -1, // source cannot be destination
    ALREADY_EXISTS = -2, // account already exist
    INVALID_WEIGHT = -3, // sum of weight with different identity must be more or equal threshold
	NO_SUCH_ROLE = -4,
	INVALID_SIGNER_DATA = -5,
	NO_SIGNER_DATA = -6 // empty signer data array not allowed
};

struct CreateAccountSuccess
{
    uint64 sequentialID;

	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union CreateAccountResult switch (CreateAccountResultCode code)
{
case SUCCESS:
    CreateAccountSuccess success;
case INVALID_SIGNER_DATA:
    ManageSignerResultCode createSignerErrorCode;
default:
    void;
};

}
