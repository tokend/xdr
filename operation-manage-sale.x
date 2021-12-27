%#include "xdr/types.h"
%#include "xdr/ledger-entries-sale.h"
%#include "reviewable-request-sale.h"

namespace stellar
{

enum ManageSaleAction
{
    CREATE_UPDATE_DETAILS_REQUEST = 1,
    CANCEL = 2,
    UPDATE_TIME = 3
};


/* Can update sale details, cancel sale, set sale state and update sales with "promotion" state

Result: ManageSaleResult

*/
//: Details regarding the `Update Sale Details` request
struct UpdateSaleDetailsData {
    //: ID of a reviewable request. If set 0, request is created, else - request is updated
    uint64 requestID; // if requestID is 0 - create request, else - update
    //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails;
    //: (optional) Bit mask whose flags must be cleared in order for UpdateSaleDetailsRequest to be approved,
    //: which will be used instead of key-value by key sale_update_tasks:<asset_code>
    uint32* allTasks;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Details are valid if one of the fileds is not zero
struct UpdateTimeData {
    //: start time can be updated if sale is not started yet (zero means no changes)
    uint64 newStartTime; 
    //: end time should be greater than start time (zero means no changes)
    uint64 newEndTime;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: ManageSaleOp is used to cancel a sale, or create a reviewable request which, after approval, will update sale details.
struct ManageSaleOp
{
    //: ID of the sale to manage
    uint64 saleID;
    //: data is used to pass ManageSaleAction along with required parameters
    union switch (ManageSaleAction action) {
    case CREATE_UPDATE_DETAILS_REQUEST:
        UpdateSaleDetailsData updateSaleDetailsData;
    case CANCEL:
        void;
    case UPDATE_TIME:
        UpdateTimeData updateTime;
    } data;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result codes for ManageSaleOperation
enum ManageSaleResultCode
{
    //: Operation is successfully applied
    SUCCESS = 0,
    //: Sale with provided ID is not found
    SALE_NOT_FOUND = -1, // sale not found

    // errors related to action "CREATE_UPDATE_DETAILS_REQUEST"
    //: CreatorDetails is not a valid JSON
    INVALID_CREATOR_DETAILS = -2, // newDetails field is invalid JSON
    //: Request to update sale with provided ID already exists
    UPDATE_DETAILS_REQUEST_ALREADY_EXISTS = -3,
    //: UpdateSaleDetails request with provided ID is not found
    UPDATE_DETAILS_REQUEST_NOT_FOUND = -4,
    //: It is not allowed to set allTasks for a pending reviewable request
    NOT_ALLOWED_TO_SET_TASKS_ON_UPDATE = -5, // not allowed to set allTasks on request update
    //: Update sale details tasks are not set in the system, i.e. it's not allowed to perform the update of sale details 
    SALE_UPDATE_DETAILS_TASKS_NOT_FOUND = -6,
    //: Both fields are zero
    INVALID_UPDATE_TIME_DATA = -7,
    //: Start time could not be updated (sale has already started)
    INVALID_START_TIME = -8,
    //: End time could not be less than start time
    INVALID_END_TIME = -9
};

//:Result of ManageSale operation successful application 
struct ManageSaleResultSuccess
{
    //: Indicates  whether or not the ManageSale request was auto approved and fulfilled
    bool fulfilled; // can be used for any reviewable request type created with manage sale operation   

    //: response is used for additional information regarding the action performed on sale during operation application
    union switch (ManageSaleAction action) {
    case CREATE_UPDATE_DETAILS_REQUEST:
        uint64 requestID;
    case CANCEL:
        void;
    case UPDATE_TIME:
        void;
    } response;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of ManageSale operation application along with result code
union ManageSaleResult switch (ManageSaleResultCode code)
{
case SUCCESS:
    ManageSaleResultSuccess success;
default:
    void;
};

}
