

%#include "xdr/Stellar-reviewable-request-AML-alert.h"

namespace stellar
{

/* CreateAMLAlertRequestOp

    Creates AML alert request

    Threshold: high

    Result: CreateAMLAlertRequestResult
*/
//: CreateAMLAlertRequest operation creates reviewable request which after approval will void provided amount
//: from target balance
struct CreateAMLAlertRequestOp
{
    //: Reference of AMLAlertRequest
    string64 reference;
    //: Parameters of AMLAlertRequest
    AMLAlertRequest amlAlertRequest;
    //: (optional) Bit mask whose flags must be cleared in order for AMLAlert to be approved, which will be used
    //: instead of key-value by key aml_alert_tasks:<asset_code>
    uint32* allTasks;

    //: Reserved for future use
	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CreateAMLAlertRequest Result ********/
//: Result codes for CreateAMLAlert operation
enum CreateAMLAlertRequestResultCode
{
    // codes considered as "success" for the operation
    //: Operation successfully applied
    SUCCESS = 0,
    //: Balance with provided balance ID does not exist
    BALANCE_NOT_EXIST = 1, // balance doesn't exist
    //: Creator details are not valid JSON
    INVALID_CREATOR_DETAILS = 2, //invalid reason for request
    //:
    UNDERFUNDED = 3, //when couldn't lock balance
    //: AML Alert request with the same reference already exists
    REFERENCE_DUPLICATION = 4, // reference already exists
    //: Amount must be positive
    INVALID_AMOUNT = 5, // amount must be positive
    //: Amount precision and asset precision set in the system are mismatched
    INCORRECT_PRECISION = 6,

    //codes considered as "failure" for the operation
    //: Update aml alert tasks are not set in the system, i.e. it's not allowed to perform aml alert
    AML_ALERT_TASKS_NOT_FOUND = -1

};

//: Result of successful application of CreateAMLAlert operation
struct CreateAMLAlertRequestSuccess {
    //: ID of the newly created reviewable request
	uint64 requestID;
    //: Indicates  whether or not the AMLAlert request was approved and applied on creation
    bool fulfilled;
    //: Reserved for future use
	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of CreateAMLAlertRequest operation application along with result code
union CreateAMLAlertRequestResult switch (CreateAMLAlertRequestResultCode code)
{
    case SUCCESS:
        CreateAMLAlertRequestSuccess success;
    default:
        void;
};

}
