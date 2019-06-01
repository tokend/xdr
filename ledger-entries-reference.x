

%#include "xdr/types.h"

namespace stellar
{

struct ReferenceEntry
{
	AccountID sender;
    string64 reference;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
}
