// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/types.h"
%#include "xdr/ledger-entries-account.h"
%#include "xdr/ledger-entries-signer.h"
%#include "xdr/ledger-entries-reference.h"
%#include "xdr/ledger-entries-reviewable-request.h"
%#include "xdr/ledger-entries-key-value.h"
%#include "xdr/ledger-entries-account-KYC.h"
%#include "xdr/ledger-entries-account-role.h"
%#include "xdr/ledger-entries-account-rule.h"
%#include "xdr/ledger-entries-signer-role.h"
%#include "xdr/ledger-entries-signer-rule.h"

namespace stellar
{


struct LedgerEntry
{
    uint32 lastModifiedLedgerSeq; // ledger the LedgerEntry was last changed

    union switch (LedgerEntryType type)
    {
    case ACCOUNT:
        AccountEntry account;
    case SIGNER:
        SignerEntry signer;
    case REFERENCE_ENTRY:
        ReferenceEntry reference;
	case REVIEWABLE_REQUEST:
		ReviewableRequestEntry reviewableRequest;
	case KEY_VALUE:
	    KeyValueEntry keyValue;
	case ACCOUNT_KYC:
        AccountKYCEntry accountKYC;
    case ACCOUNT_ROLE:
        AccountRoleEntry accountRole;
    case ACCOUNT_RULE:
        AccountRuleEntry accountRule;
    case SIGNER_RULE:
        SignerRuleEntry signerRule;
    case SIGNER_ROLE:
        SignerRoleEntry signerRole;
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
