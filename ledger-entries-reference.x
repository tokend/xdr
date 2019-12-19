

%#include "xdr/types.h"

namespace stellar
{

struct ReferenceEntry
{
	AccountID sender;
    string64 reference;
    OperationType opType;
    uint32 securityType;

	// reserved for future use
	EmptyExt ext;
};
}
