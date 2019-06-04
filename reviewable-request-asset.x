%#include "xdr/types.h"

namespace stellar
{

//: AssetCreationRequest is used to create an asset with provided parameters
struct AssetCreationRequest {
    //: Code of an asset to create
    AssetCode code;
    //: Public key of a signer that will perform pre issuance
    AccountID preissuedAssetSigner;
    //: Maximal amount to be issued
    uint64 maxIssuanceAmount;
    //: Amount to pre issue on asset creation
    uint64 initialPreissuedAmount;
    //: Bit mask of policies to create an asset with
    uint32 policies;
    //: Arbitrary stringified JSON object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester
     //: Type of asset, selected arbitrarily. Can be used to restrict the usage of an asset
    uint64 type;
    //: Used to keep track of rejected requests updates (`SequenceNumber` increases after each rejected AssetCreationRequest update)
    uint32 sequenceNumber;
    //: Number of significant decimal places
    uint32 trailingDigitsCount;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: AssetUpdateRequest is used to update an asset with provided parameters
struct AssetUpdateRequest {
    //: Code of an asset to update
    AssetCode code;
    //: Arbitrary stringified JSON object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester
    //: New policies to set will override the existing ones
    uint32 policies;
    //: Used to keep track of rejected requests update (`SequenceNumber` increases after each rejected AssetUpdateRequest update).
    uint32 sequenceNumber;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: AssetChangePreissuedSigner is used to update a pre issued asset signer
struct AssetChangePreissuedSigner
{
    //: code of an asset to update
    AssetCode code;
    //: Public key of a signer that will be the new pre issuer
    AccountID accountID;
    //: Content signature of a pre issuer signer
    //: Content equals hash of `<code>:<accountID>`
    DecoratedSignature signature;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
