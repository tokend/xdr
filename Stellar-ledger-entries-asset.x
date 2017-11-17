// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

enum AssetPolicy
{
	ASSET_TRANSFERABLE = 1,
    ASSET_EMITTABLE_PRIMARY = 2,
    ASSET_EMITTABLE_SECONDARY = 4
};



struct AssetEntry
{
    AssetCode code;
    int32 policies;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
