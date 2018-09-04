%#include "xdr/Stellar-types.h"

namespace stellar
{

struct ASwapRequest
{
    uint64 bidID;
    uint64 amount;
    uint64 fee;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

}