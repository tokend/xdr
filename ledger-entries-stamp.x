%#include "xdr/types.h"


namespace stellar
{

struct StampEntry
{
    Hash ledgerHash;
    Hash licenseHash;

     // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}