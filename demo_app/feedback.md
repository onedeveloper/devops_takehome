# Feedback

## Quests feedback:

- Composition route is a bit strange:
  - Could use id of composition instead of parent_id + material_id
  - Otherwise, could have been a nested route inside materialsRouter
- Going through the composition tree seems to have traversals that could have been avoided.
  - Ex: Why get base materials and sub-materials separately?
  - Tree construction requires traversing the whole tree from the top.
    - Alternative: Make compositions recursive CTE reusable, and use it to recalculate power level by modifying the CTE. In other words, let the CTE do the work rather than just using it to fetch the date, construct a tree, and so on
- findNode: if there are multiple branches with the same parent material required, findNode will only find the first match.
- getMaxQuantity
  - the `sum` should instead be the min of the outputs of getMaxQuantity for the submaterials. As it is, it is taking the buildable qty of the material if each submaterial was the only material required.
  - While iterating, the use of a material's qty is not being considered during traversal. Ex: If material 1 is required in two branches, and was used to build submaterials in branch 1, then branch 2 should consider the use of material 1 in branch 1.

## Other:

- Should use JS Error class for error handling
- No DB-level constraint on Composition's parent_id + material_id; it's possible to have 2 records with the same parent and same material (but different qty)
  - This also shows why Compositions CRUD should be based on its id
  - The existing composition check on Create is okay but not ideal
- Circular reference check for Compositions could be done before creation/update
- It's strange that a Composition's material_id can be updated, as the Composition would basically be completely different