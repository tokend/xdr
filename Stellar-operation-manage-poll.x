%#include "xdr/Stellar-reviewable-request-create-poll.h"

namespace stellar
{

//: Actions that can be applied to a `CREATE_POLL` request
enum ManagePollAction
{
    CREATE_REQUEST = 0,
    CANCEL_REQUEST = 1,
    CLOSE = 2//,
//    UPDATE_END_TIME = 3
};

//: PollResult is used to specify result of voting
enum PollResult
{
    PASSED = 0,
    FAILED = 1
};

//: ClosePollData is used to submit poll results
struct ClosePollData
{
    //: ID of poll to close
    uint64 pollID;

    //: result of voting
    PollResult result;

    //: Arbitrary stringified json object with details about the result
    longstring details;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


//: CreatePollRequestData is used to pass necessary data to create a `CREATE_POLL` request
struct CreatePollRequestData
{
    //: Body of `CREATE_POLL` request
    CreatePollRequest request;

    //: Bit mask that will be used instead of the value from key-value entry by
    //: `create_poll_tasks:<permissionType>` key
    uint32* allTasks;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: CancelPollRequestData is used to pass necessary data to remove a `CREATE_POLL` request
struct CancelPollRequestData
{
    uint64 requestID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: ManagePollOp is used to create or remove a `CREATE_POLL` request, or to close existing poll
struct ManagePollOp
{
    //: data is used to pass one of `ManagePollAction` with required params
    union switch (ManagePollAction action)
    {
    case CREATE_REQUEST:
        CreatePollRequestData createData;
    case CANCEL_REQUEST:
        CancelPollRequestData cancelData;
    case CLOSE:
        ClosePollData closeData;
    }
    data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result codes of ManagePollOp
enum ManagePollResultCode
{
    //: `CREATE_POLL` request has either been successfully created
    //: or auto approved
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Passed details have invalid json structure
    INVALID_CREATOR_DETAILS = -1,
    //: There is no `CREATE_POLL` request with such id
    NOT_FOUND = -2,
    INVALID_DATES = -3,
    INVALID_START_TIME = -4,
    INVALID_END_TIME = -5,
    //: There is no key-value entry by `create_poll_tasks:<permissionType>` key in the system;
    //: configuration does not allow to create `CREATE_POLL` request with such `permissionType`
    CREATE_POLL_TASKS_NOT_FOUND = -6,
    RESULT_PROVIDER_NOT_FOUND = -7,
    POLL_NOT_READY = -8,
    NOT_AUTHORIZED_TO_CLOSE_POLL = -9
};

//: CreatePollRequestResponse is used to pass useful fields after `CREATE_POLL` request creation
struct CreatePollRequestResponse
{
    //: ID of a created request
    uint64 requestID;

    //: Indicates whether or not the `CREATE_POLL` request was auto approved and fulfilled
    //: True means that poll was successfully created
    bool fulfilled;

    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Success result of operation application
struct ManagePollSuccessResult
{
    //: `details` id used to pass useful fields
    union switch (ManagePollAction action)
    {
    case CREATE_REQUEST:
        CreatePollRequestResponse response;
    case CANCEL_REQUEST:
        void;
    case CLOSE:
        void;
    } details;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of ManagePollOp application
union ManagePollResult switch (ManagePollResultCode code)
{
case SUCCESS:
    ManagePollSuccessResult success;
default:
    void;
};

}
