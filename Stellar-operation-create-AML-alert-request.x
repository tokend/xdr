

%#include "xdr/Stellar-reviewable-request-AML-alert.h"

namespace stellar
{

/* CreateAMLAlertRequestOp

    Creates AML alert request

    Threshold: high

    Result: CreateAMLAlertRequestResult
*/

struct CreateAMLAlertRequestOp
{
    string64 reference;
    AMLAlertRequest amlAlertRequest;

    uint32* allTasks;
    
	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CreateAMLAlertRequest Result ********/

enum CreateAMLAlertRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,
    BALANCE_NOT_EXIST = 1, // balance doesn't exist
    INVALID_REASON = 2, //invalid reason for request
    UNDERFUNDED = 3, //when couldn't lock balance
    REFERENCE_DUPLICATION = 4, // reference already exists
    INVALID_AMOUNT = 5, // amount must be positive
    INCORRECT_PRECISION = 6,

    //codes considered as "failure" for the operation
    AML_ALERT_TASKS_NOT_FOUND = -1

};

struct CreateAMLAlertRequestSuccess {
	uint64 requestID;
    bool fulfilled;
	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


union CreateAMLAlertRequestResult switch (CreateAMLAlertRequestResultCode code)
{
    case SUCCESS:
        CreateAMLAlertRequestSuccess success;
    default:
        void;
};

}
