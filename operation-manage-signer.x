%#include "xdr/types.h"

namespace stellar
{

/* ManageSigner
Creates, update or remove a signer.

Result: ManageSignerResult

*/

//: Actions that can be applied to a signer
enum ManageSignerAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

//: UpdateSignerData is used to pass necessary data to create or update the signer
struct UpdateSignerData
{
    //: Public key of a signer
    PublicKey publicKey;
    //: id of the role that will be attached to a signer
    uint64 roleID;

    //: weight that signer will have, threshold for all SignerRequirements equals 1000
    uint32 weight;
    //: If there are some signers with equal identity, only one signer will be chosen 
    //: (either the one with the biggest weight or the one who was the first to satisfy a threshold) 
    uint32 identity;

    //: Arbitrary stringified json object with details that will be attached to signer
    longstring details;

    //: reserved for future extension
    EmptyExt ext;
};

//: RemoveSignerData is used to pass necessary data to remove a signer
struct RemoveSignerData
{
    //: Public key of an existing signer
    PublicKey publicKey;

    //: reserved for future extension
    EmptyExt ext;
};

//: ManageSignerOp is used to create, update or remove a signer
struct ManageSignerOp
{
    //: data is used to pass one of `ManageSignerAction` with required params
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
    //: Specified action in `data` of ManageSignerOp was successfully executed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Passed details have invalid json structure
    INVALID_DETAILS = -1, // invalid json details
    //: Signer with such public key is already attached to the source account
    ALREADY_EXISTS = -2, // signer already exist
    //: There is no role with such id
    NO_SUCH_ROLE = -3,
    //: It is not allowed to set weight more than 1000
    INVALID_WEIGHT = -4, // more than 1000
    //: Source account does not have a signer with the provided public key
    NOT_FOUND = -5, // there is no signer with such public key
    //: only occurs during the creation of signers for admins if the number of signers exceeds the number specified in a license
	NUMBER_OF_ADMINS_EXCEEDS_LICENSE = -6
};

//: Result of operation application
union ManageSignerResult switch (ManageSignerResultCode code)
{
case SUCCESS:
    //: reserved for future extension
    EmptyExt ext;
default:
    void;
};

}
