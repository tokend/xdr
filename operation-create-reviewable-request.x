namespace stellar
{

struct CreateReviewableRequestOp
{
    ReviewableRequestOperation operations<>;

    EmptyExt ext;
};

enum CreateReviewableRequestResultCode
{
    SUCCESS = 0,

    INVALID_OPERATION = -1,
    TASKS_NOT_FOUND = -2,
    TOO_MANY_OPERATIONS = -3
};

struct CreateReviewableRequestSuccessResult 
{
    uint64 requestID;
    bool isFulfilled;

    EmptyExt ext;
};

union CreateReviewableRequestResult switch (CreateReviewableRequestResultCode code)
{
case SUCCESS:
    CreateReviewableRequestSuccessResult success;
case INVALID_OPERATION:
    OperationResult operationResult;
case TOO_MANY_OPERATIONS:
    uint32 maxOperationsCount;
default:
    void;
};
}