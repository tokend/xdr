// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct LimitsUpdateRequest {
    Hash deprecatedDocumentHash;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    case LIMITS_UPDATE_REQUEST_DEPRECATED_DOCUMENT_HASH:
        longstring details;
    }
    ext;
};

}