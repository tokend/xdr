// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/types.h"

namespace stellar
{

struct RecoveryEntry
{
    AccountID accountID;

    AccountID recoveryProviders<>;

    uint32 power;

    EmptyExt ext;
};
}
