namespace stellar
{

struct CreateReviewableRequestOp
{
    ReviewableRequestOperationBody operations<>;

    EmptyExt ext;
};

enum CreateReviewableRequestResultCode
{
    SUCCESS = 0,

    INVALID_OPERATION = -1,
    TASKS_NOT_FOUND = -2,
    TOO_MANY_OPERATIONS = -3
};

union CreateReviewableRequestResult switch (CreateReviewableRequestResultCode code)
{
case SUCCESS:
    EmptyExt ext;
case INVALID_OPERATION:
    OperationResultTr operationResult;
case TOO_MANY_OPERATIONS:
    uint32 maxOperationsCount;
default:
    void;
};
}