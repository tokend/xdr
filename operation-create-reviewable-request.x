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

    INVALID_OPERATION = -1
};

union CreateReviewableRequestResult switch (CreateReviewableRequestResultCode code)
{
case SUCCESS:
    EmptyExt ext;
case INVALID_OPERATION:
    OperationResultTr operationResult;
default:
    void;
};
}