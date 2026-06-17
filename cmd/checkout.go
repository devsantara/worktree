package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

var checkoutCmd = &cobra.Command{
	Use:   "checkout",
	Short: "Checkout a worktree",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Running checkout command")
	},
}

func init() {
	rootCmd.AddCommand(checkoutCmd)
}
