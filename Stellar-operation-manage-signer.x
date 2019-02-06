%#include "xdr/Stellar-types.h"

namespace stellar
{

/* ManageSigner
Creates, update or remove a signer.

Result: ManageSignerResult

*/

enum ManageSignerAction
{
    CREATE = 0,
    UPDATE = 1,
    REMOVE = 2
};

struct UpdateSignerData
{
    PublicKey publicKey;
    uint64 roleID;

    uint32 weight; // threshold for all SignerRules equals 1000
    uint32 identity;

    string256 details;

    EmptyExt ext;
};

struct RemoveSignerData
{
    PublicKey publicKey;

    EmptyExt ext;
};

struct ManageSignerOp
{
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

    EmptyExt ext;
};

/******* ManageSigner Result ********/

enum ManageSignerResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0, // account was created

    // codes considered as "failure" for the operation
    INVALID_DETAILS = -1, // invalid json details
    ALREADY_EXISTS = -2, // signer already exist
	NO_SUCH_ROLE = -3,
	INVALID_WEIGHT = -4, // more than 1000
	NOT_FOUND = -5 // there is no signer with such public key
};

union ManageSignerResult switch (ManageSignerResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};

}
