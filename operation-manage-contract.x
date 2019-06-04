

%#include "xdr/ledger-entries.h"

namespace stellar
{

/* Adds details to contract, starts disputes, confirms contract

Threshold: med

Result: ManageContractResult
*/

enum ManageContractAction
{
    ADD_DETAILS = 0,
    CONFIRM_COMPLETED = 1,
    START_DISPUTE = 2,
    RESOLVE_DISPUTE = 3
};

struct ManageContractOp
{
    uint64 contractID;

    union switch (ManageContractAction action)
    {
    case ADD_DETAILS:
        longstring details;
    case CONFIRM_COMPLETED:
        void;
    case START_DISPUTE:
        longstring disputeReason;
    case RESOLVE_DISPUTE:
        bool isRevert;
    }
    data;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageContract Result ********/

enum ManageContractResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,
    NOT_FOUND = -2, // not found contract
    NOT_ALLOWED = -3, // only contractor or customer can add details
    DETAILS_TOO_LONG = -4,
    DISPUTE_REASON_TOO_LONG = -5,
    ALREADY_CONFIRMED = -6,
    INVOICE_NOT_APPROVED = -7, // all contract invoices must be approved
    DISPUTE_ALREADY_STARTED = -8,
    CUSTOMER_BALANCE_OVERFLOW = -9,
    INCORRECT_PRECISION = -10
};

struct ManageContractResponse
{
    union switch (ManageContractAction action)
    {
    case CONFIRM_COMPLETED:
        bool isCompleted;
    default:
        void;
    }
    data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageContractResult switch (ManageContractResultCode code)
{
case SUCCESS:
    ManageContractResponse response;
default:
    void;
};

}
