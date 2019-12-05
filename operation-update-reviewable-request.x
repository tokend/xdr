namespace stellar
{

struct UpdateReviewableRequestOp
{
    uint64 requestID;

    ReviewableRequestOperation operations<>;

    EmptyExt ext;
};

enum UpdateReviewableRequestResultCode
{
    SUCCESS = 0,

    INVALID_OPERATION = -1,
    TASKS_NOT_FOUND = -2,
    TOO_MANY_OPERATIONS = -3,
    NOT_FOUND = -4,
    SECURITY_TYPE_MISMATCH = -5
};

union UpdateReviewableRequestResult switch (UpdateReviewableRequestResultCode code)
{
case SUCCESS:
    EmptyExt ext;
case INVALID_OPERATION:
    OperationResult operationResult;
case TOO_MANY_OPERATIONS:
    uint32 maxOperationsCount;
default:
    void;
};

}