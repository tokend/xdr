%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-sale.h"
%#include "Stellar-reviewable-request-sale.h"

namespace stellar
{

enum ManageSaleAction
{
    CREATE_UPDATE_DETAILS_REQUEST = 1,
    CANCEL = 2,
	SET_STATE = 3,
	CREATE_PROMOTION_UPDATE_REQUEST = 4,
	CREATE_UPDATE_END_TIME_REQUEST = 5
};


/* Can update sale details, cancel sale, set sale state and update sales with "promotion" state

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

struct PromotionUpdateData {
    uint64 requestID; // if requestID is 0 - create request, else - update
    SaleCreationRequest newPromotionData;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct UpdateSaleEndTimeData {
    uint64 requestID; // if requestID is 0 - create request, else - update
    uint64 newEndTime;

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
    case CREATE_PROMOTION_UPDATE_REQUEST:
        PromotionUpdateData promotionUpdateData;
    case CREATE_UPDATE_END_TIME_REQUEST:
        UpdateSaleEndTimeData updateSaleEndTimeData;
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
    INVALID_NEW_DETAILS = -2, // newDetails field is invalid JSON
    UPDATE_DETAILS_REQUEST_ALREADY_EXISTS = -3,
    UPDATE_DETAILS_REQUEST_NOT_FOUND = -4,

    // errors related to action "SET_STATE"
    NOT_ALLOWED = -5, // it's not allowed to set state for non master account

    // errors related to action "CREATE_PROMOTION_UPDATE_REQUEST"
    PROMOTION_UPDATE_REQUEST_INVALID_ASSET_PAIR = -6, // one of the assets has invalid code or base asset is equal to quote asset
    PROMOTION_UPDATE_REQUEST_INVALID_PRICE = -7, // price cannot be 0
    PROMOTION_UPDATE_REQUEST_START_END_INVALID = -8, // sale ends before start
    PROMOTION_UPDATE_REQUEST_INVALID_CAP = -9, // hard cap is < soft cap
    PROMOTION_UPDATE_REQUEST_INVALID_DETAILS = -10, // details field is invalid JSON
    INVALID_SALE_STATE = -11, // sale state must be "PROMOTION"
    PROMOTION_UPDATE_REQUEST_ALREADY_EXISTS = -12,
    PROMOTION_UPDATE_REQUEST_NOT_FOUND = -13,

    // errors related to action "CREATE_UPDATE_END_TIME_REQUEST"
    INVALID_NEW_END_TIME = -14, // new end time is before start time or current ledger close time
    UPDATE_END_TIME_REQUEST_ALREADY_EXISTS = -15,
    UPDATE_END_TIME_REQUEST_NOT_FOUND = -16
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
    case CREATE_PROMOTION_UPDATE_REQUEST:
        uint64 promotionUpdateRequestID;
	case CREATE_UPDATE_END_TIME_REQUEST:
	    uint64 updateEndTimeRequestID;
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
