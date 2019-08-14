// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/types.h"
%#include "xdr/ledger-entries-account.h"
%#include "xdr/ledger-entries-masked-data.h"
%#include "xdr/ledger-entries-masked-data-confirmation.h"
%#include "xdr/ledger-entries-recovery.h"
%#include "xdr/ledger-entries-identifier.h"
%#include "xdr/ledger-entries-identifier-confirmation.h"

namespace stellar
{


struct LedgerEntry
{
    uint32 lastModifiedLedgerSeq; // ledger the LedgerEntry was last changed

    union switch (LedgerEntryType type)
    {
    case ACCOUNT:
        AccountEntry account;
    case MASKED_DATA:
        MaskedDataEntry maskedData;
    case IDENTIFIER:
        IdentifierEntry identifier;
    case RECOVERY:
        RecoveryEntry recovery;
    case IDENTIFIER_CONFIRMATION:
        IdentifierConfirmationEntry identifierConfirmation;
    case MASKED_DATA_CONFIRMATION:
        MaskedDataConfirmationEntry maskedDataConfirmation;
    }
    data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

// list of all envelope types used in the application
// those are prefixes used when building signatures for
// the respective envelopes
enum EnvelopeType
{
    SCP = 1,
    TX = 2,
    AUTH = 3
};
}
