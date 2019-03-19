%#include "xdr/Stellar-reviewable-request-create-poll.h"

namespace stellar
{

enum ManageCreatePollRequestAction
{
    CREATE = 0,
    REMOVE = 1
};

struct CreatePollRequestData
{
    CreatePollRequest request;

    uint32* allTasks;
    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct RemoveCreatePollRequestData
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

struct ManageCreatePollRequestOp
{
    union switch (ManageCreatePollRequestAction action)
    {
    case CREATE:
        CreatePollRequestData createData;
    case REMOVE:
        RemoveCreatePollRequestData removeData;
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

enum ManageCreatePollRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    INVALID_DETAILS = -1,
    NOT_FOUND = -2, // not found contract request, when try to remove


    CREATE_POLL_TASKS_NOT_FOUND = -6 // key-value not set
};

struct CreatePollRequestResponse
{
    uint64 requestID;
    bool fulfilled;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ManageCreatePollRequestSuccessResult
{
    union switch (ManageCreatePollRequestAction action)
    {
    case CREATE:
        CreatePollRequestResponse response;
    case REMOVE:
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

union ManageCreatePollRequestResult switch (ManageCreatePollRequestResultCode code)
{
case SUCCESS:
    ManageCreatePollRequestSuccessResult success;
default:
    void;
};

}