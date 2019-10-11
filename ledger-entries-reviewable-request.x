

%#include "xdr/types.h"
%#include "xdr/reviewable-request-asset.h"
%#include "xdr/reviewable-request-issuance.h"
%#include "xdr/reviewable-request-withdrawal.h"
%#include "xdr/reviewable-request-sale.h"
%#include "xdr/reviewable-request-change-role.h"
%#include "xdr/reviewable-request-limits-update.h"
%#include "xdr/reviewable-request-AML-alert.h"
%#include "xdr/reviewable-request-update-sale-details.h"
%#include "xdr/reviewable-request-invoice.h"
%#include "xdr/reviewable-request-contract.h"
%#include "xdr/reviewable-request-atomic-swap-ask.h"
%#include "xdr/reviewable-request-atomic-swap-bid.h"
%#include "xdr/reviewable-request-create-poll.h"
%#include "xdr/reviewable-request-kyc-recovery.h"

namespace stellar
{

enum ReviewableRequestType
{
	NONE = 0, // use this request type in ReviewRequestOp extended result if additional info is not required
	ANY = 1,
	CREATE_ISSUANCE = 3,
	CREATE_WITHDRAW = 4,
	CHANGE_ROLE = 8,
	CREATE_ASSET = 10,
	UPDATE_ASSET = 13,
	KYC_RECOVERY = 18
};

// ReviewableRequest - request reviewable by admin
struct ReviewableRequestEntry {
	uint64 requestID;
	Hash hash; // hash of the request body
	AccountID requestor;
	longstring rejectReason;
	AccountID reviewer;
	string64* reference; // reference for request which will act as an unique key for the request (will reject request with the same reference from same requestor)
	int64 createdAt; // when request was created

	union switch (ReviewableRequestType type) {
		case CREATE_ASSET:
			AssetCreationRequest assetCreationRequest;
		case UPDATE_ASSET:
			AssetUpdateRequest assetUpdateRequest;
		case CREATE_ISSUANCE:
			IssuanceRequest issuanceRequest;
		case CREATE_WITHDRAW:
			WithdrawalRequest withdrawalRequest;
        case CHANGE_ROLE:
            ChangeRoleRequest changeRoleRequest;
        case KYC_RECOVERY:
            KYCRecoveryRequest kycRecoveryRequest;
	} body;

	uint32 allTasks;
    uint32 pendingTasks;

    // External details vector consists of comments written by request reviewers
    longstring externalDetails<>;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
	}
    ext;
};

}
