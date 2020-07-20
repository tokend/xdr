%#include "xdr/types.h"

namespace stellar
{

struct CreateDataOp
{
    //: Numeric type, used for access control
    uint64 type;
    //: Value to store
    longstring value;

    //: Reserved for future extension
    EmptyExt ext;
};

enum CreateDataResultCode
{
    //: Data entry was successfully created
    SUCCESS = 0,
    //: `value` must be in a valid JSON format
    INVALID_DATA = -1
};

struct CreateDataSuccess
{
    //: ID of created data entry
    uint64 dataID;
    //: Reserved for future extension
    EmptyExt ext;
};

//: Result of operation application
union CreateDataResult switch (CreateDataResultCode code)
{
    case SUCCESS:
        //: Result of successful operation application
        CreateDataSuccess success;
    default:
        void;
};
}