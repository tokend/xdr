%#include "xdr/types.h"

namespace stellar
{

struct ChangeKeyOp
{
    PublicKey key;

    //: reserved for future extension
    EmptyExt ext;
};

/******* ChangeKey Result ********/

enum ChangeKeyResultCode
{
    SUCCESS = 0

};

//: Result of operation application
union ChangeKeyResult switch (ChangeKeyResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};

}
