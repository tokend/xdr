namespace stellar
{

struct RemoveReviewableRequestOp
{

    unit64 requestID;


    EmptyExt ext;
};

enum RemoveReviewableRequestResultCode
{
    SUCCESS = 0,


    NOT_FOUND = -1
};

union RemoveReviewableRequestResult switch (RemoveReviewableRequestResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};

}