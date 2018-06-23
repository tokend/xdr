%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-sale.h"

namespace stellar
{

enum ManageSaleAction
{
    CREATE_UPDATE_DETAILS_REQUEST = 1,
    CANCEL = 2,
	SET_STATE = 3
};


/* Can update sale details

Result: ManageSaleResult

*/

struct UpdateSaleDetailsData {
    uint64 requestID; // if requestID is 0 - create request, else - update
    longstring newDetails;

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
	case SET_STATE:
		SaleState saleState;
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
    INVALID_NEW_DETAILS = -2, // newDetails field is invalid JSON
    UPDATE_DETAILS_REQUEST_ALREADY_EXISTS = -3,
    UPDATE_DETAILS_REQUEST_NOT_FOUND = -4,
	NOT_ALLOWED = -5 // it's not allowed to set state for non master account
};

struct ManageSaleResultSuccess
{
    union switch (ManageSaleAction action) {
    case CREATE_UPDATE_DETAILS_REQUEST:
        uint64 requestID;
    case CANCEL:
        void;
	case SET_STATE:
		void;
    } response;

    //reserved for future use
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
