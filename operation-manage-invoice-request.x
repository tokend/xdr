%#include "xdr/ledger-entries.h"

namespace stellar
{

/* Creates or deletes an invoice

Threshold: med

Result: ManageInvoiceRequestResult

*/

enum ManageInvoiceRequestAction
{
    CREATE = 0,
    REMOVE = 1
};

struct InvoiceCreationRequest
{
    AssetCode asset;
    AccountID sender;
    uint64 amount; // not allowed to set 0

    uint64 *contractID;
    longstring details;

    uint32* allTasks;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ManageInvoiceRequestOp
{
    union switch (ManageInvoiceRequestAction action){
    case CREATE:
        InvoiceCreationRequest invoiceRequest;
    case REMOVE:
        uint64 requestID;
    } details;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageInvoiceRequest Result ********/

enum ManageInvoiceRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,
    BALANCE_NOT_FOUND = -2, // sender balance not found
    NOT_FOUND = -3, // not found invoice request, when try to remove
    TOO_MANY_INVOICES = -4,
    DETAILS_TOO_LONG = -5,
    NOT_ALLOWED_TO_REMOVE = -6, // only invoice creator can remove invoice
    CONTRACT_NOT_FOUND = -7,
    ONLY_CONTRACTOR_CAN_ATTACH_INVOICE_TO_CONTRACT = -8,
    SENDER_ACCOUNT_MISMATCHED = -9,
    INVOICE_IS_APPROVED = -10, // not allowed to remove approved invoice
    INVOICE_TASKS_NOT_FOUND = -11
};

struct CreateInvoiceRequestResponse
{
	BalanceID receiverBalance;
	BalanceID senderBalance;

	uint64 requestID;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageInvoiceRequestResult switch (ManageInvoiceRequestResultCode code)
{
case SUCCESS:
    struct
    {
        bool fulfilled;
        union switch (ManageInvoiceRequestAction action)
        {
        case CREATE:
            CreateInvoiceRequestResponse response;
        case REMOVE:
            void;
        } details;

        // reserved for future use
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } success;
default:
    void;
};

}
