%#include "xdr/Stellar-types.h"

namespace stellar
{

/* ManageSigner
Creates, update or remove a signer.

Result: ManageSignerResult

*/

//: Actions which can be applied to signer
enum ManageSignerAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

//: UpdateSignerData is used to pass necessary data to create or update signer
struct UpdateSignerData
{
    //: Public key of signer
    PublicKey publicKey;
    //: id of role that will be attached to signer
    uint64 roleID;

    //: weight that signer will have, threshold for all SignerRequirements equals 1000
    uint32 weight;
    //: If there are some signers with equal identity, signer with the biggest weight
    //: will be chosen or the first one that satisfied the threshold
    uint32 identity;

    //: Arbitrary stringified json object that will be attached to signer
    longstring details;

    //: reserved for future extension
    EmptyExt ext;
};

//: RemoveSignerData is used to pass necessary data to remove signer
struct RemoveSignerData
{
    //: Public key of existing signer
    PublicKey publicKey;

    //: reserved for future extension
    EmptyExt ext;
};

//: ManageSignerOp is used to create, update or remove signer
struct ManageSignerOp
{
    //: data is used to pass one of `ManageSignerAction` with needed params
    union switch (ManageSignerAction action)
    {
    case CREATE:
        UpdateSignerData createData;
    case UPDATE:
        UpdateSignerData updateData;
    case REMOVE:
        RemoveSignerData removeData;
    }
    data;

    //: reserved for future extension
    EmptyExt ext;
};

/******* ManageSigner Result ********/

//: Result codes of ManageSignerOp
enum ManageSignerResultCode
{
    //: Means that specified action in `data` of ManageSignerOp was successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Passed details has invalid json structure
    INVALID_DETAILS = -1, // invalid json details
    //: Signer with such public key already attached to source account
    ALREADY_EXISTS = -2, // signer already exist
    //: There is no role with such id
	NO_SUCH_ROLE = -3,
	//: There is not necessary to set weight more than 1000
	INVALID_WEIGHT = -4, // more than 1000
	//: There is no signer with such public key for source account
	NOT_FOUND = -5 // there is no signer with such public key
};

//: Result of operation applying
union ManageSignerResult switch (ManageSignerResultCode code)
{
case SUCCESS:
    //: reserved for future extension
    EmptyExt ext;
default:
    void;
};

}
