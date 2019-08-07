struct CreateDataOp 
{
    longstring data;

    EmptyExt ext;
};

enum CreateDataResultCode
{
    SUCCESS = 0,

    INVALID_DATA = -1
};

union CreateDataResult switch (CreateDataResultCode code)
{
    case SUCCESS:
        EmptyExt;
    default:
        void;
};