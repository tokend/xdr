%#include "xdr/Stellar-types.h"

namespace stellar
{

enum ManageSaleAction
{
    UPDATE_DETAILS = 1
};


/* Can update sale details

Result: ManageSaleResult

*/

struct ManageSaleOp
{
    uint64 saleID;

    union switch (ManageSaleAction action) {
    case UPDATE_DETAILS:
        longstring newDetails;
    default:
        void;
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

    NOT_FOUND = -1 // sale not found
};

struct ManageSaleResultSuccess
{
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
