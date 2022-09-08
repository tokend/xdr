

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
%#include "xdr/reviewable-request-manage-offer.h"
%#include "xdr/reviewable-request-payment.h"
%#include "xdr/reviewable-request-redemption.h"
%#include "xdr/reviewable-request-create-data.h"
%#include "xdr/reviewable-request-update-data.h"
%#include "xdr/reviewable-request-remove-data.h"
%#include "xdr/reviewable-request-create-deferred-payment.h"
%#include "xdr/reviewable-request-close-deferred-payment.h"
%#include "xdr/reviewable-request-update-data-owner.h"

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
	CREATE_ATOMIC_SWAP_ASK = 16,
	CREATE_ATOMIC_SWAP_BID = 17,
	KYC_RECOVERY = 18,
	MANAGE_OFFER = 19,
	CREATE_PAYMENT = 20,
	PERFORM_REDEMPTION = 21,
	DATA_CREATION = 22,
	DATA_UPDATE = 23,
	DATA_REMOVE = 24,
	CREATE_DEFERRED_PAYMENT = 25,
    CLOSE_DEFERRED_PAYMENT = 26,
    DATA_OWNER_UPDATE = 27
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
        case CREATE_ATOMIC_SWAP_ASK:
            CreateAtomicSwapAskRequest createAtomicSwapAskRequest;
        case CREATE_ATOMIC_SWAP_BID:
            CreateAtomicSwapBidRequest createAtomicSwapBidRequest;
        case CREATE_POLL:
            CreatePollRequest createPollRequest;
        case KYC_RECOVERY:
            KYCRecoveryRequest kycRecoveryRequest;
		case MANAGE_OFFER:
			ManageOfferRequest manageOfferRequest;
		case CREATE_PAYMENT:
			CreatePaymentRequest createPaymentRequest;
        case PERFORM_REDEMPTION:
            RedemptionRequest redemptionRequest;
        case DATA_CREATION:
            DataCreationRequest dataCreationRequest;
        case DATA_UPDATE:
            DataUpdateRequest dataUpdateRequest;
        case DATA_REMOVE:
            DataRemoveRequest dataRemoveRequest;
        case CREATE_DEFERRED_PAYMENT:
            CreateDeferredPaymentRequest createDeferredPaymentRequest;
        case CLOSE_DEFERRED_PAYMENT:
            CloseDeferredPaymentRequest closeDeferredPaymentRequest;
        case DATA_OWNER_UPDATE:
            DataOwnerUpdateRequest dataOwnerUpdateRequest;

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
