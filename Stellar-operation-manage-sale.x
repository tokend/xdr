%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-sale.h"
%#include "Stellar-reviewable-request-sale.h"

namespace stellar
{

enum ManageSaleAction
{
    CREATE_UPDATE_DETAILS_REQUEST = 1,
    CANCEL = 2
};


/* Can update sale details, cancel sale, set sale state and update sales with "promotion" state

Result: ManageSaleResult

*/

struct UpdateSaleDetailsData {
    uint64 requestID; // if requestID is 0 - create request, else - update
    longstring creatorDetails;

    uint32* allTasks;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct ManageSaleOp
{
    uint64 saleID;

    union switch (ManageSaleAction action) {
    case CREATE_UPDATE_DETAILS_REQUEST:
        UpdateSaleDetailsData updateSaleDetailsData;
    case CANCEL:
        void;
    } data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};


enum ManageSaleResultCode
{
    SUCCESS = 0,

    SALE_NOT_FOUND = -1, // sale not found

    // errors related to action "CREATE_UPDATE_DETAILS_REQUEST"
    INVALID_CREATOR_DETAILS = -2, // newDetails field is invalid JSON
    UPDATE_DETAILS_REQUEST_ALREADY_EXISTS = -3,
    UPDATE_DETAILS_REQUEST_NOT_FOUND = -4,
    NOT_ALLOWED_TO_SET_TASKS_ON_UPDATE = -5, // not allowed to set allTasks on request update
    SALE_UPDATE_DETAILS_TASKS_NOT_FOUND = -6 // it's not allowed to set state for non master account
};

struct ManageSaleResultSuccess
{
    bool fulfilled; // can be used for any reviewable request type created with manage sale operation   
 
    union switch (ManageSaleAction action) {
    case CREATE_UPDATE_DETAILS_REQUEST:
        uint64 requestID;
    case CANCEL:
        void;
    } response;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageSaleResult switch (ManageSaleResultCode code)
{
case SUCCESS:
    ManageSaleResultSuccess success;
default:
    void;
};

}
