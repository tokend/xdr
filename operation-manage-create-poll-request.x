%#include "xdr/reviewable-request-create-poll.h"

namespace stellar
{

//: Actions that can be applied to a `CREATE_POLL` request
enum ManageCreatePollRequestAction
{
    CREATE = 0,
    CANCEL = 1
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
    //: ID of `CREATE_POLL` request to remove
    uint64 requestID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: ManageCreatePollRequestOp is used to create or remove a `CREATE_POLL` request
struct ManageCreatePollRequestOp
{
    //: data is used to pass one of `ManageCreatePollRequestAction` with required params
    union switch (ManageCreatePollRequestAction action)
    {
    case CREATE:
        CreatePollRequestData createData;
    case CANCEL:
        CancelPollRequestData cancelData;
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

//: Result codes of ManageCreatePollRequestOp
enum ManageCreatePollRequestResultCode
{
    //: `CREATE_POLL` request has either been successfully created
    //: or auto approved
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Passed details have invalid json structure
    INVALID_CREATOR_DETAILS = -1,
    //: There is no `CREATE_POLL` request with such id
    NOT_FOUND = -2,
    //: Not allowed to create poll which has `endTime` not later than `startTime`
    INVALID_DATES = -3,
    //: Not allowed to create poll which `endTime` early than currentTime
    INVALID_END_TIME = -4,
    //: There is no account which such id
    RESULT_PROVIDER_NOT_FOUND = -5,
    //: There is no key-value entry by `create_poll_tasks:<permissionType>` key in the system;
    //: configuration does not allow to create `CREATE_POLL` request with such `permissionType`
    CREATE_POLL_TASKS_NOT_FOUND = -6,
    //: Not allowed to create poll with zero number of choices
    INVALID_NUMBER_OF_CHOICES = -7
};

//: CreatePollRequestResponse is used to pass useful fields after `CREATE_POLL` request creation
struct CreatePollRequestResponse
{
    //: ID of a created request
    uint64 requestID;

    //: Indicates whether or not the `CREATE_POLL` request was auto approved and fulfilled
    //: True means that poll was successfully created
    bool fulfilled;

    //: ID of created poll if request was fulfilled
    uint64* pollID;

    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Success result of operation application
struct ManageCreatePollRequestSuccessResult
{
    //: `details` id used to pass useful fields
    union switch (ManageCreatePollRequestAction action)
    {
    case CREATE:
        CreatePollRequestResponse response;
    case CANCEL:
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

//: Result of ManageCreatePollRequestOp application
union ManageCreatePollRequestResult switch (ManageCreatePollRequestResultCode code)
{
case SUCCESS:
    ManageCreatePollRequestSuccessResult success;
default:
    void;
};

}
