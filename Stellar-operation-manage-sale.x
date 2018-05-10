%#include "xdr/Stellar-types.h"

namespace stellar
{

enum ManageSaleAction
{
    CREATE_UPDATE_DETAILS_REQUEST = 1
};


/* Can update sale details

Result: ManageSaleResult

*/

struct ManageSaleOp
{
    uint64 saleID;

    union switch (ManageSaleAction action) {
    case CREATE_UPDATE_DETAILS_REQUEST:
        longstring newDetails;
    } data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


enum ManageSaleResultCode
{
    SUCCESS = 0,

    NOT_FOUND = -1, // sale not found
    INVALID_NEW_DETAILS = -2 // newDetails field is invalid JSON
};

struct ManageSaleResultSuccess
{
    union switch (ManageSaleAction action) {
    case CREATE_UPDATE_DETAILS_REQUEST:
        uint64 requestID;
    } response;

    //reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageSaleResult switch (ManageSaleResultCode code)
{
case SUCCESS:
    ManageSaleResultSuccess success;
default:
    void;
};

}
