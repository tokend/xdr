

%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-reviewable-request-asset.h"
%#include "xdr/Stellar-reviewable-request-issuance.h"
%#include "xdr/Stellar-reviewable-request-withdrawal.h"
%#include "xdr/Stellar-reviewable-request-sale.h"
%#include "xdr/Stellar-reviewable-request-change-role.h"
%#include "xdr/Stellar-reviewable-request-limits-update.h"
%#include "xdr/Stellar-reviewable-request-AML-alert.h"
%#include "xdr/Stellar-reviewable-request-update-sale-details.h"
%#include "xdr/Stellar-reviewable-request-invoice.h"
%#include "xdr/Stellar-reviewable-request-contract.h"
%#include "xdr/Stellar-reviewable-request-atomic-swap-ask.h"
%#include "xdr/Stellar-reviewable-request-atomic-swap-bid.h"
%#include "xdr/Stellar-reviewable-request-create-poll.h"

namespace stellar
{

enum ReviewableRequestType
{
	NONE = 0, // use this request type in ReviewRequestOp extended result if additional info is not required
	ANY = 1,
	CREATE_PRE_ISSUANCE = 2,
	CREATE_ISSUANCE = 3,
	CREATE_WITHDRAW = 4,
	CREATE_SALE = 5,
	UPDATE_LIMITS = 6,
    CREATE_AML_ALERT = 7,
	CHANGE_ROLE = 8,
	UPDATE_SALE_DETAILS = 9,
	CREATE_ASSET = 10,
	CREATE_INVOICE = 11,
	MANAGE_CONTRACT = 12,
	UPDATE_ASSET = 13,
	CREATE_POLL = 14,
	CREATE_ATOMIC_SWAP_BID = 16,
	CREATE_ATOMIC_SWAP_ASK = 17
};

struct TasksExt {
    // Tasks are represented by a bitmask
    uint32 allTasks;
    uint32 pendingTasks;

    // External details vector consists of comments written by request reviewers
    longstring externalDetails<>;

    // Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
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
		case CREATE_PRE_ISSUANCE:
			PreIssuanceRequest preIssuanceRequest;
		case CREATE_ISSUANCE:
			IssuanceRequest issuanceRequest;
		case CREATE_WITHDRAW:
			WithdrawalRequest withdrawalRequest;
		case CREATE_SALE:
			SaleCreationRequest saleCreationRequest;
        case UPDATE_LIMITS:
            LimitsUpdateRequest limitsUpdateRequest;
        case CREATE_AML_ALERT:
            AMLAlertRequest amlAlertRequest;
        case CHANGE_ROLE:
            ChangeRoleRequest changeRoleRequest;
        case UPDATE_SALE_DETAILS:
            UpdateSaleDetailsRequest updateSaleDetailsRequest;
        case CREATE_INVOICE:
            InvoiceRequest invoiceRequest;
        case MANAGE_CONTRACT:
            ContractRequest contractRequest;
        case CREATE_ATOMIC_SWAP_BID:
            CreateAtomicSwapBidRequest createAtomicSwapBidRequest;
        case CREATE_ATOMIC_SWAP_ASK:
            CreateAtomicSwapAskRequest createAtomicSwapAskRequest;
        case CREATE_POLL:
            CreatePollRequest createPollRequest;
	} body;

	TasksExt tasks;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
	}
    ext;
};

}