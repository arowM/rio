-- | @List@. Import as:
--
-- > import qualified RIO.List as L
module RIO.List
  (
  -- * Basic functions
    (Data.List.++)
  , Data.List.uncons
  , Data.List.null
  , Data.List.length
  , headMaybe
  , lastMaybe
  , tailMaybe
  , initMaybe

  -- * List transformations
  , Data.List.map
  , Data.List.reverse

  , Data.List.intersperse
  , Data.List.intercalate
  , Data.List.transpose

  , Data.List.subsequences
  , Data.List.permutations

  -- * Reducing lists (folds)

  , Data.List.foldl
  , Data.List.foldl'
  , Data.List.foldr

  -- ** Special folds

  , Data.List.concat
  , Data.List.concatMap
  , Data.List.and
  , Data.List.or
  , Data.List.any
  , Data.List.all
  , Data.List.sum
  , Data.List.product
  , maximumMaybe
  , minimumMaybe
  , maximumByMaybe
  , minimumByMaybe

  -- * Building lists

  -- ** Scans
  , Data.List.scanl
  , Data.List.scanl'
  , Data.List.scanr
  , Data.List.scanl1
  , Data.List.scanr1

  -- ** Accumulating maps
  , Data.List.mapAccumL
  , Data.List.mapAccumR

  -- ** Infinite lists
  , Data.List.iterate
  , Data.List.repeat
  , Data.List.replicate
  , Data.List.cycle

  -- ** Unfolding
  , Data.List.unfoldr

  -- * Sublists

  -- ** Extracting sublists
  , Data.List.take
  , Data.List.drop
  , Data.List.splitAt

  , Data.List.takeWhile
  , Data.List.dropWhile
  , Data.List.dropWhileEnd
  , Data.List.span
  , Data.List.break

  , Data.List.stripPrefix
  , stripSuffix
  , dropPrefix
  , dropSuffix

  , Data.List.group

  , Data.List.inits
  , Data.List.tails

  -- ** Predicates
  , Data.List.isPrefixOf
  , Data.List.isSuffixOf
  , Data.List.isInfixOf
  , Data.List.isSubsequenceOf

  -- * Searching lists

  -- ** Searching by equality
  , Data.List.elem
  , Data.List.notElem
  , Data.List.lookup

  -- ** Searching with a predicate
  , Data.List.find
  , Data.List.filter
  , Data.List.partition

  -- * Indexing lists
  -- | These functions treat a list @xs@ as a indexed collection,
  -- with indices ranging from 0 to @'length' xs - 1@.

  , Data.List.elemIndex
  , Data.List.elemIndices

  , Data.List.findIndex
  , Data.List.findIndices

  -- * Zipping and unzipping lists

  , Data.List.zip
  , Data.List.zip3
  , Data.List.zip4
  , Data.List.zip5
  , Data.List.zip6
  , Data.List.zip7

  , Data.List.zipWith
  , Data.List.zipWith3
  , Data.List.zipWith4
  , Data.List.zipWith5
  , Data.List.zipWith6
  , Data.List.zipWith7

  , Data.List.unzip
  , Data.List.unzip3
  , Data.List.unzip4
  , Data.List.unzip5
  , Data.List.unzip6
  , Data.List.unzip7

  -- * Special lists

  -- ** Functions on strings
  , Data.List.lines
  , linesCR
  , Data.List.words
  , Data.List.unlines
  , Data.List.unwords

  -- ** \"Set\" operations

  , Data.List.nub

  , Data.List.delete
  , (Data.List.\\)

  , Data.List.union
  , Data.List.intersect

  -- ** Ordered lists
  , Data.List.sort
  , Data.List.sortOn
  , Data.List.insert

  -- * Generalized functions

  -- ** The \"@By@\" operations
  -- | By convention, overloaded functions have a non-overloaded
  -- counterpart whose name is suffixed with \`@By@\'.
  --
  -- It is often convenient to use these functions together with
  -- 'Data.Function.on', for instance @'sortBy' ('compare'
  -- \`on\` 'fst')@.

  -- *** User-supplied equality (replacing an @Eq@ context)
  -- | The predicate is assumed to define an equivalence.
  , Data.List.nubBy
  , Data.List.deleteBy
  , Data.List.deleteFirstsBy
  , Data.List.unionBy
  , Data.List.intersectBy
  , Data.List.groupBy

  -- *** User-supplied comparison (replacing an @Ord@ context)
  -- | The function is assumed to define a total ordering.
  , Data.List.sortBy
  , Data.List.insertBy

  -- ** The \"@generic@\" operations
  -- | The prefix \`@generic@\' indicates an overloaded function that
  -- is a generalized version of a "Prelude" function.

  , Data.List.genericLength
  , Data.List.genericTake
  , Data.List.genericDrop
  , Data.List.genericSplitAt
  , Data.List.genericIndex
  , Data.List.genericReplicate

  ) where

import qualified Data.List

import Data.List(stripPrefix)
import Data.Maybe (fromMaybe)

-- | Remove the suffix from the given list, if present
--
-- @since 0.0.0
stripSuffix :: Eq a
            => [a] -- ^ suffix
            -> [a]
            -> Maybe [a]
stripSuffix suffix list =
  fmap reverse (stripPrefix (reverse suffix) (reverse list))

-- | Drop prefix if present, otherwise return original list.
--
-- @since 0.0.0.0
dropPrefix :: Eq a
           => [a] -- ^ prefix
           -> [a]
           -> [a]
dropPrefix prefix t = fromMaybe t (stripPrefix prefix t)

-- | Drop prefix if present, otherwise return original list.
--
-- @since 0.0.0.0
dropSuffix :: Eq a
           => [a] -- ^ suffix
           -> [a]
           -> [a]
dropSuffix suffix t = fromMaybe t (stripSuffix suffix t)

-- | 'linesCR' breaks a 'String' up into a list of `String`s at newline
-- 'Char's. It is very similar to 'lines', but it also removes any
-- trailing @'\r'@ 'Char's. The resulting 'String' values do not contain
-- newlines or trailing @'\r'@ characters.
--
-- @since 0.1.0.0
linesCR :: String -> [String]
linesCR = map (dropSuffix "\r") . lines

safeListCall :: Foldable t => (t a -> b) -> t a -> Maybe b
safeListCall f xs
  | Data.List.null xs = Nothing
  | otherwise = Just $ f xs

-- | @since 0.1.3.0
headMaybe :: [a] -> Maybe a
headMaybe = safeListCall Data.List.head

-- | @since 0.1.3.0
lastMaybe :: [a] -> Maybe a
lastMaybe = safeListCall Data.List.last

-- | @since 0.1.3.0
tailMaybe :: [a] -> Maybe [a]
tailMaybe = safeListCall Data.List.tail

-- | @since 0.1.3.0
initMaybe :: [a] -> Maybe [a]
initMaybe = safeListCall Data.List.init

-- | @since 0.1.3.0
maximumMaybe :: (Ord a, Foldable t) => t a -> Maybe a
maximumMaybe = safeListCall Data.List.maximum

-- | @since 0.1.3.0
minimumMaybe :: (Ord a, Foldable t) => t a -> Maybe a
minimumMaybe = safeListCall Data.List.minimum

-- | @since 0.1.3.0
maximumByMaybe :: (Ord a, Foldable t) => (a -> a -> Ordering) -> t a -> Maybe a
maximumByMaybe f = safeListCall (Data.List.maximumBy f)

-- | @since 0.1.3.0
minimumByMaybe :: (Ord a, Foldable t) => (a -> a -> Ordering) -> t a -> Maybe a
minimumByMaybe f = safeListCall (Data.List.minimumBy f)
