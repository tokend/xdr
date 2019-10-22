%#include "xdr/types.h"

namespace stellar
{

//: RemoveSignerData is used to pass necessary data to remove a signer
struct RemoveSignerOp
{
    //: Public key of an existing signer
    PublicKey publicKey;

    //: reserved for future extension
    EmptyExt ext;
};


//: Result codes of ManageSignerOp
enum RemoveSignerResultCode
{
    //: Specified action in `data` of ManageSignerOp was successfully executed
    SUCCESS = 0,

    //: Source account does not have a signer with the provided public key
    NOT_FOUND = -1 // there is no signer with such public key
};

//: Result of operation application
union RemoveSignerResult switch (RemoveSignerResultCode code)
{
case SUCCESS:
    //: reserved for future extension
    EmptyExt ext;
default:
    void;
};

}
